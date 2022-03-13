


package bootstrap;

import java.io.ByteArrayOutputStream;

public class Driver {

    private static ByteArrayOutputStream bos = new ByteArrayOutputStream();

    public static void main(String[] args) {
        EncDecryptor encDecryptor = new EncDecryptor("Group2_ABCDEFGHIFK_1234567890123");

        encDecryptor.encryptImage(
                "D:\\Clear\\ImgEncryDecry\\src\\main\\resources\\yoru.jpg",
                "D:\\Clear\\ImgEncryDecry\\src\\main\\resources\\yoruEncry.jpg");
        System.out.println("Image Encrypted");


        encDecryptor.decryptImage("D:\\Clear\\ImgEncryDecry\\src\\main\\resources\\yoruEncry.jpg","D:\\Clear\\ImgEncryDecry\\src\\main\\resources\\yoruDecry.jpg");
        System.out.println("Image Decrypted");
    }
}

//home page - bootup - key input
//image selection - image file ka path
//gallery - every encryted image -> decrypt -> display
//
