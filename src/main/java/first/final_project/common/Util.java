package first.final_project.common;

import java.io.File;

public class Util {

    public static void createDirectoryIfNotExists(String directoryPath) {
        File saveDir = new File(directoryPath);

        // Check if the directory does not exist
        if (!saveDir.exists()) {
            // Create the directory and any necessary parent directories
            boolean wasCreated = saveDir.mkdirs();

            // Optionally handle the result of directory creation
            if (wasCreated) {
                System.out.println("폴더생성 성공 ");
            } else {
                System.out.println("폴더생성 실패");
            }
        } else {
            System.out.println("폴더는 이미 존재합니다.");
        }
    }

}
