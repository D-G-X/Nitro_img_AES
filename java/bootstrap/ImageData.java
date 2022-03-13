package bootstrap;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;

public class ImageData {
    public static byte[] imageToByteArray(String path, ByteArrayOutputStream bos) {
        byte[] data;
        try {
            BufferedImage bImage = ImageIO.read(new File("D:\\Clear\\ImgEncryDecry\\src\\main\\resources\\yoru.jpg"));
            ImageIO.write(bImage, "jpg", bos);
            data = bos.toByteArray();
        } catch (Exception e) {
            System.out.println(e);
            data = new byte[1];
        }
        return data;
    }

    public static void byteArrayToImageFile(String outputPath, byte[] data){
        try {
            ByteArrayInputStream bis = new ByteArrayInputStream(data);
            System.out.println("byte array bis.");
            BufferedImage bImage2 = ImageIO.read(bis);
            System.out.println("Buffered Image");
            ImageIO.write(bImage2, "jpg", new File(outputPath));
            System.out.println("image created");
        } catch (Exception e){
            System.out.println("Error: ImageData.byteArrayToImageFile:\t"+e);
        }
    }
}