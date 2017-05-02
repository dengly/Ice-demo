package com.zzwtec.iceclient2;

import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import java.io.InputStream;

public class MainActivity extends AppCompatActivity {

    private TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textView = (TextView) findViewById(R.id.txt);

        new Thread(new Runnable() {
            @Override
            public void run() {
                int androidSDKVersion = Build.VERSION.SDK_INT;
                InputStream certStream = getResources().openRawResource(R.raw.client);
                String iceSSLPsw = "123456";
                String iceRouter = "DemoGlacier2/router:ssl -p 4063 -h 192.168.0.112 -t 10000";
                IceUtil.init(androidSDKVersion,
                        certStream,
                        iceSSLPsw,
                        iceRouter);
                if(IceUtil.connect()){
                    // TODO 通过IceUtil.getObjectPrx() 获取你的服务代理器操作。
                    // 如 TicketServicePrx ticketServicePrx = IceUtil.getObjectPrx(TicketServicePrx.class);
                }
            }
        }).start();
    }


}
