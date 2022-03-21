package dgx.nitro.nitro_img_aes;
//https://stackoverflow.com/questions/65396008/flutter-io-flutter-app-flutteractivity-is-already-defined-in-a-single-type-impo
//https://www.youtube.com/watch?v=k4f_VYIKAp8

import android.annotation.SuppressLint;
import android.os.Bundle;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    List<EncDecryptor> encryptorDecryptor = new ArrayList<EncDecryptor>();
    ThreadFactory threadFactory = Executors.defaultThreadFactory();
    ExecutorService executorService = Executors.newFixedThreadPool(1,threadFactory);
    private static final String CHANNEL = "com.flutter.nitro/AES";

    @SuppressLint("SdCardPath")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(),CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {

                    if (methodCall.method.equals("Printy")){
                        String path = methodCall.argument("path");
                        EncDecryptor encDecryptor = new EncDecryptor("Group2_ABCDEFGHIFK_1234567890123",true,path);
                        encryptorDecryptor.add(encDecryptor);
                        try {
                            executorService.invokeAll(encryptorDecryptor);
                        } catch (InterruptedException e) {
                            System.out.println("Error: Unable to Encrypt");
                        }
                        encryptorDecryptor.clear();
//                        executorService.shutdown();
                        result.success(" ");
                    } else
                    if (methodCall.method.equals("decryptImage")){
                        String decryptedImagePath = methodCall.argument("path");
                        EncDecryptor encDecryptor = new EncDecryptor("Group2_ABCDEFGHIFK_1234567890123",false,decryptedImagePath);
                        encryptorDecryptor.add(encDecryptor);
                        try {
                            executorService.invokeAll(encryptorDecryptor);
                        } catch (InterruptedException e) {
                            System.out.println("Error: Unable to Decrypt");
                            e.printStackTrace();
                        }
                        encryptorDecryptor.clear();
//                        executorService.shutdown();
                        result.success(" ");
                    }
                }
        );
    }
}
