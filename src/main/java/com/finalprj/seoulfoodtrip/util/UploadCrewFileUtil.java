package com.finalprj.seoulfoodtrip.util;

import com.finalprj.seoulfoodtrip.dto.crew.CrewDTO;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class UploadCrewFileUtil extends UploadFileUtil{
    private final String ROOT_PATH;
    private final String CREW_LOGO_IMG_PATH;

    public UploadCrewFileUtil(String uploadPath) {
        super(uploadPath);
        this.ROOT_PATH = uploadPath;
        this.CREW_LOGO_IMG_PATH = ROOT_PATH + "/crew/logo/";
    }

    //temp 이미지들 후기글 이미지 폴더생성후 이동
    public void moveImagesCrew(Long postNo, String uploadImg) {

        String[] uploadImgs = uploadImg.split(",");

        for (int i = 0; i < uploadImgs.length; i++) {
            Path src = Paths.get(ROOT_PATH.toString() + "/crew/board/temp/" + uploadImgs[i]);
            Path dst = Paths.get(ROOT_PATH.toString() + "/crew/board/" + postNo + "/" + uploadImgs[i]);

            File noDirectory = new File(ROOT_PATH.toString() + "/crew/board/" + postNo);
            if (!noDirectory.exists()) {
                noDirectory.mkdirs();
            }
            try {

                Files.move(src, dst, StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    //이미지폴더 이미지들 temp로 이동 (크루)
    public void moveToTempCrew(Long postNo) {
        File imageDir = new File(ROOT_PATH.toString() + "/crew/board/" + postNo);

        if (imageDir.exists()) {

            File[] files = imageDir.listFiles();

            //Temp로 해당 파일 이동
            if (files != null) {
                for (File file : files) {

                    Path src = Paths.get(ROOT_PATH.toString() + "/crew/board/" + postNo + "/" + file.getName());
                    Path dst = Paths.get(ROOT_PATH.toString() + "/crew/board/temp/" + file.getName());
                    try {

                        Files.move(src, dst, StandardCopyOption.REPLACE_EXISTING);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
            System.out.println("temp로 파일 이동");
        }
    }

    //크루 활동글 삭제시 이미지삭제
    public void deleteCrewImages(Long postNo) {
        Path path = Paths.get(ROOT_PATH.toString() + "/crew/board/" + postNo);
        File imageDir = new File(path.toString());

        if (imageDir.exists()) {
            File[] files = imageDir.listFiles();
            if (files != null) {
                for (int i = 0; i < files.length; i++) {
                    boolean isDeleted = files[i].delete();
                    logWhenDeleteFile(isDeleted, files[i].getPath());
                }
            }
        }

        try {
            Files.delete(path);
            System.out.println(postNo + "번 이미지 디렉토리 삭제 됨");
        } catch (IOException e) {
            System.out.println(postNo + "번 이미지 디렉토리 삭제 실패");
            e.printStackTrace();
        }
    }

    //크루 이미지 저장 (기존 이미지 있으면 삭제하고 새로 저장)
    public String updateCrewLogo(CrewDTO dto, MultipartFile crewImgFile) throws IOException {
        //기존이미지 삭제
        File oldfile = new File(CREW_LOGO_IMG_PATH + dto.getCrewImgFileName());
        deleteFile(oldfile);

        //저장될 파일 이름 생성 : 크루이름.확장자
        String crewImagePath = CREW_LOGO_IMG_PATH + makeSaveName(crewImgFile.getOriginalFilename(), dto.getCrewName());
        File fileToSave = new File(crewImagePath);

        //파일 저장
        crewImgFile.transferTo(fileToSave);

        return fileToSave.getName();
    }

}
