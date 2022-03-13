package bootstrap;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.spec.SecretKeySpec;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.Key;
import java.util.Base64;

public class EncDecryptor {
    private final String ALGO = "AES";
    private int encrypLength = 0;
    private byte[] keyValue;
    Key key;

    public EncDecryptor(String key){
//        ALGO = algo;
        keyValue = key.getBytes();
    }

    public String encryptString(String data) {
        try {
            key = generateKey();
            Cipher c = Cipher.getInstance(ALGO);
            c.init(Cipher.ENCRYPT_MODE, key);
            byte[] encVal = c.doFinal((data.getBytes()));
            System.out.println("Encry:"+new String(encVal).length());
            encrypLength = new String(encVal).length();
            String x = Base64.getEncoder().encodeToString(encVal);
            System.out.println("Encoded:"+x.length());
            return x;
        } catch (Exception e){
            System.out.println("Error: "+e);
            return "";
        }
    }

    public String decryptString(String data){
        try {
            Key key = generateKey();
            Cipher c = Cipher.getInstance(ALGO);
            c.init(Cipher.DECRYPT_MODE, key);
            byte[] decodedValue = new byte[encrypLength+1];
            byte[] encryptedValue = data.getBytes();
            Base64.getDecoder().decode(encryptedValue,decodedValue);
//            System.out.println(new String(decodedValue));
            byte[] decryValue = c.doFinal(decodedValue);
            return new String(decryValue);

        } catch (Exception e){
            System.out.println("Error: "+e.getLocalizedMessage());
            return "";
        }
    }

//    public byte[] encrypt(byte[] data) {
//        try {
//            Key key = generateKey();
//            Cipher c = Cipher.getInstance(ALGO);
//            c.init(Cipher.ENCRYPT_MODE, key);
//            byte[] encVal = c.doFinal((data));
//            encrypLength = new String(encVal).length();
//            ByteBuffer encodeBuff = Base64.getEncoder().encode(ByteBuffer.wrap(encVal));
//            byte[] encodedVal = new byte[encodeBuff.remaining()];
//            encodeBuff.get(encodedVal,0,encodedVal.length);
//            encodeBuff.clear();
////            System.out.println(x.length());
//            System.out.println("Encrypted");
//            return encodedVal;
//        } catch (Exception e){
//            System.out.println("Error: "+e);
//            return new byte[1];
//        }
//    }

    public void encryptImage(String inputFilePath, String encryptedFilePath) {
        try {
            key = generateKey();
            Cipher c = Cipher.getInstance(ALGO);
            c.init(Cipher.ENCRYPT_MODE, key);
            CipherInputStream cipt = new CipherInputStream(new FileInputStream(new File(inputFilePath)), c);
            FileOutputStream fileip = new FileOutputStream(new File(encryptedFilePath));
            int i;
            while ((i = cipt.read()) != -1) {
                fileip.write(i);
            }
            fileip.close();
        } catch (Exception e){
            System.out.println("Error: "+e);
        }
    }

    public void decryptImage(String encryptedFilePath, String decryptedFilePath){
        try {
            Cipher c = Cipher.getInstance(ALGO);
            c.init(Cipher.DECRYPT_MODE, key);
            CipherInputStream ciptt = new CipherInputStream(new FileInputStream(new File(encryptedFilePath)), c);
            FileOutputStream fileop = new FileOutputStream(new File(decryptedFilePath));
            int j;
            while ((j = ciptt.read()) != -1) {
                fileop.write(j);
            }
        } catch (Exception e){
            System.out.println("Error: "+e);
        }
    }
    public Key generateKey(){
        return new SecretKeySpec(keyValue,ALGO);
    }

}
