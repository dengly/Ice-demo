//
//  ViewController.m
//  IceClient
//
//  Created by 邓燎燕 on 15/12/28.
//  Copyright © 2015年 邓燎燕. All rights reserved.
//

#import "ViewController.h"
#import "IceClientUtil.h"
#import "IceGlacier2Util.h"
#import <objc/Ice.h>
#import <ticket.h>
@protocol ICECommunicator;
@protocol ticketTicketServicePrx;

//TYPE=0 Locator的普通方式
//TYPE=1 Locator的配置方式
//TYPE=2 Router的SSL方式
#define TYPE 2

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController{
    NSMutableArray * datas;
    id<ICECommunicator> communicator;
    id<ticketTicketServicePrx> ticketServicePrx;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //创建communicator
    communicator = [self createCommunicator];
    //执行业务
    [self doBusiness];
}

//创建communicator
-(id<ICECommunicator>)createCommunicator{
    id<ICECommunicator> _communicator = nil;
    switch (TYPE) {
        case 0://Locator的普通方式
        {
            ICEInitializationData* initData = [ICEInitializationData initializationData];
            initData.properties = [ICEUtil createProperties];
            [initData.properties setProperty:@"Ice.Default.Locator" value:@"IceGrid/Locator:tcp -h 192.168.0.112 -p 4061"];
            initData.dispatcher = ^(id<ICEDispatcherCall> call, id<ICEConnection> con)
            {
                dispatch_sync(dispatch_get_main_queue(), ^ { [call run]; });
            };
            NSAssert(communicator == nil, @"communicator == nil");
            _communicator = [ICEUtil createCommunicator:initData];
        }
            break;
        case 1://Locator的配置方式
        {
            _communicator = [IceClientUtil getICECommunicator];
        }
            break;
        case 2://Router的SSL方式
        {
            _communicator = [IceGlacier2Util getICECommunicator];
        }
            break;
        default:
            break;
    }
    return _communicator;
}

//执行业务
-(void)doBusiness{
    switch (TYPE) {
        case 0://Locator的普通方式
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
                @try {
                    ICEObjectPrx* base = [communicator stringToProxy:@"TicketService"];
                    base = [base ice_invocationTimeout:5000]; //调用超时时间单位毫秒
                    ticketServicePrx = [ticketTicketServicePrx checkedCast:base];
                    NSLog(@"%@",[NSThread callStackSymbols]);
                    ticketMutableOrderSeq* orders = [ticketServicePrx queryMyOrders:@"13631276694"];
                    datas = orders;
                    [self.tableView reloadData];
                } @catch(ICEEndpointParseException* ex) {
                    NSString* s = [NSString stringWithFormat:@"Invalid router: %@", ex.reason];
                    dispatch_async(dispatch_get_main_queue(), ^ {
                        [self exception:s];
                    });
                } @catch(ICEException* ex) {
                    dispatch_async(dispatch_get_main_queue(), ^ {
                        [self exception:[ex description]];
                    });
                }
            });
        }
            break;
        case 1://Locator的配置方式
        {
            [IceClientUtil serviceAsync:^{
                ticketServicePrx = [IceClientUtil getServicePrx:@"TicketService" class:[ticketTicketServicePrx class]];
                [self queryTicket];
            }];
        }
            break;
        case 2://Router的SSL方式
        {
            [IceGlacier2Util serviceAsync:^{
                ticketServicePrx = [IceGlacier2Util getServicePrx:@"TicketService" class:[ticketTicketServicePrx class]];
                [self queryTicket];
            }];
        }
            break;
        default:
            break;
    }
}

-(void)queryTicket{
    if ([ticketServicePrx isKindOfClass:[ticketTicketServicePrx class]]) {
        ticketMutableOrderSeq* orders = [ticketServicePrx queryMyOrders:@"13631276694"];
        datas = orders;
        dispatch_sync(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
    }else if ([ticketServicePrx isKindOfClass:[ICEEndpointParseException class]]) {
        ICEException * ex = (ICEException *)ticketServicePrx;
        NSString* s = [NSString stringWithFormat:@"Invalid router: %@", ex.reason];
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self exception:s];
        });
    }else if ([ticketServicePrx isKindOfClass:[ICEException class]]) {
        NSException * ex = (NSException *)ticketServicePrx;
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self exception:[ex description]];
        });
    }else if ([ticketServicePrx isKindOfClass:[NSException class]]) {
        NSException * ex = (NSException *)ticketServicePrx;
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self exception:[ex description]];
        });
    }
}

-(void)exception:(NSString*)s {
    [self destroyCommunicator];
    
    UIApplication* app = [UIApplication sharedApplication];
    if(app.applicationState != UIApplicationStateBackground) {
        // open an alert with just an OK button
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:s
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
-(void)destroyCommunicator {
    communicator = nil;
    switch (TYPE) {
        case 0://Locator的普通方式
        {
            __block id<ICECommunicator> c = communicator;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
                @try {
                    [c destroy];
                } @catch (ICEException* ex) {
                }
            });
        }
            break;
        case 1://Locator的配置方式
        {
            [IceClientUtil closeCommunicator:YES];
        }
            break;
        case 2://Router的SSL方式
        {
            [IceGlacier2Util closeCommunicator:YES];
        }
            break;
        default:
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ice_cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ice_cell"];
    }
    if (datas!=nil) {
        ticketOrder* order = datas[indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"id:%ld - orderNum:%@",order.orderId,order.orderNum]];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (datas) {
        return [datas count];
    }
    return 0;
}

@end
