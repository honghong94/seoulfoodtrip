package com.finalprj.seoulfoodtrip.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FilenameFilter;
import java.nio.file.Path;
import java.nio.file.Paths;

public class UploadReviewFileUtil extends UploadFileUtil {
    private final String ROOT_PATH;
    private final String REVIEW_IMG_PATH;
    private final String REVIEW_IMG_PATH_TEMP;

    public UploadReviewFileUtil(String uploadPath) {
        super(uploadPath);
        this.ROOT_PATH = uploadPath;
        this.REVIEW_IMG_PATH = ROOT_PATH + "/review/";
        this.REVIEW_IMG_PATH_TEMP = REVIEW_IMG_PATH + "/temp/";
    }

    public void saveCourseImg(Long reviewNo, MultipartFile courseImg) {
        if (courseImg != null) {
            makeDirIfNoExist(REVIEW_IMG_PATH + reviewNo);
            String originalCourseImgName = courseImg.getOriginalFilename();
            Path savePath = Paths.get(REVIEW_IMG_PATH + reviewNo + "/" + originalCourseImgName);
            trasferFile(courseImg, savePath);
        }
    }

    public void moveImgsTempToReviewNoDir(Long reviewNo, String uploadImgNames) {
        if (uploadImgNames != null) {
            String[] uploadImgArray = uploadImgNames.split(",");
            makeDirIfNoExist(REVIEW_IMG_PATH + reviewNo);

            for (int i = 0; i < uploadImgArray.length; i++) {
                Path src = Paths.get(REVIEW_IMG_PATH_TEMP + uploadImgArray[i]);
                Path dst = Paths.get(REVIEW_IMG_PATH + reviewNo + "/" + uploadImgArray[i]);
                moveFile(src, dst);
            }
        }
    }

    public void moveImgsReviewNoDirToTemp(Long reviewNo) {
        File reviewNoDir = new File(REVIEW_IMG_PATH + reviewNo);
        File[] reviewImgs = getImgsWithoutCourse(reviewNoDir);

        if (reviewImgs != null) {
            for (File file : reviewImgs) {
                Path src = Paths.get(REVIEW_IMG_PATH + reviewNo + "/" + file.getName());
                Path dst = Paths.get(REVIEW_IMG_PATH_TEMP + file.getName());
                moveFile(src, dst);
            }
        }
    }

    public File[] getImgsWithoutCourse(File reviewNoDir) {
        if (reviewNoDir.exists()) {
            File[] reviewImgs = reviewNoDir.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return !name.equals("course.png");
                }
            });
            return reviewImgs;
        }
        return null;
    }

    public void deleteReviewImgs(Long reviewNo) {
        Path path = Paths.get(REVIEW_IMG_PATH + reviewNo);
        File imageDir = new File(path.toString());
        deleteFilesInDir(imageDir);

        boolean isDeleted = imageDir.delete();
        logWhenDeleteFile(isDeleted, path.toString());
    }
}
