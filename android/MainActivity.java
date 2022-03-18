package dgx.nitro.nitro_img_aes;
//https://stackoverflow.com/questions/65396008/flutter-io-flutter-app-flutteractivity-is-already-defined-in-a-single-type-impo
//https://www.youtube.com/watch?v=k4f_VYIKAp8

import android.annotation.SuppressLint;
import android.os.Bundle;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

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
//                        result.success(path);
                        EncDecryptor encDecryptor = new EncDecryptor("Group2_ABCDEFGHIFK_1234567890123");
//                        System.out.print("Encrypting Image");
                        encDecryptor.encryptImage(
                                path,
                                path+".aes");
                        result.success("--From JAVA:\t"+path+".aes");
                    } else

                    if (methodCall.method.equals("decryptImage")){
                        String decryptedImagePath = methodCall.argument("path");
                        String path = decryptedImagePath+".aes";
                        EncDecryptor encDecryptor = new EncDecryptor("Group2_ABCDEFGHIFK_1234567890123");
                        encDecryptor.decryptImage(
                                path,
                                decryptedImagePath);
                        result.success("--From JAVA:\t"+decryptedImagePath);
                    }
                }
        );
    }
}
