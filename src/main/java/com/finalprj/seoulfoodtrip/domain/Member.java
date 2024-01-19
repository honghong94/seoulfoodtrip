package com.finalprj.seoulfoodtrip.domain;

import lombok.*;
import javax.persistence.*;
import java.util.Date;


@Entity
@Table(name="MEMBER_TBL")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Setter
public class Member {
    @Id
    private String id;
    private String password;
    private String name;
    private String nickname;
    private String member_img;
    private Date birth;
    private String gender;
    private String email;
    private String phone;
    private Character crleader;
}
