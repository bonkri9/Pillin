package com.ssafy.yourpilling.member.model.service.impl;

import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.member.model.dao.MemberDao;
import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.service.MemberService;
import com.ssafy.yourpilling.member.model.service.impl.mail.MemberMailSubjectContentGenerator;
import com.ssafy.yourpilling.member.model.service.impl.mail.TemporaryPasswordGenerator;
import com.ssafy.yourpilling.member.model.service.mapper.MemberServiceMapper;
import com.ssafy.yourpilling.member.model.service.vo.in.*;
import com.ssafy.yourpilling.member.model.service.vo.out.OutMemberVo;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    @Value("${spring.mail.username}")
    private String fromAddress;

    private final MemberDao memberDao;
    private final MemberServiceMapper mapper;
    private final BCryptPasswordEncoder encoder;

    private final JavaMailSender sender;
    private final MemberMailSubjectContentGenerator userMailSubjectContentGenerator;
    private final TemporaryPasswordGenerator temporaryPasswordGenerator;

    @Transactional
    @Override
    public void register(MemberRegisterVo vo) {
        memberDao.register(mapper.mapToMember(vo, encoder, Role.MEMBER));
    }

    @Transactional
    @Override
    public void registerEssential(RegisterEssentialVo vo) {
        memberDao.registerEssential(vo.getBirthday(), vo.getGender());
    }

    @Override
    public OutMemberVo info(MemberInfoVo vo) {
        MemberProfile member = memberDao.findByMemberId(vo.getMemberId());

        return mapper.mapToOutMemberVo(member);
    }

    @Transactional
    @Override
    public void updateName(MemberUpdateNameVo vo) {
        MemberProfile member = memberDao.findByMemberId(vo.getMemberId());

        member.updateName(vo.getName());
    }

    @Transactional
    @Override
    public void updatePassword(MemberUpdatePasswordVo vo) {
        MemberProfile member = memberDao.findByMemberId(vo.getMemberId());

        member.updatePassword(encoder.encode(vo.getPassword()));
    }

    @Transactional
    @Override
    public void delete(MemberDeleteVo vo) {
        memberDao.deleteByMemberId(vo.getMemberId());
    }

    @Transactional
    @Override
    public void passwordReIssue(MemberPasswordReIssueVo vo) {
        try{
            MemberProfile member = memberDao.findByMemberId(vo.getMemberId());

            String to = member.getUsername();
            String rawTmpPassword = temporaryPasswordGenerator.generatePassword();

            sendTemporaryPassword(to, rawTmpPassword);

            member.updatePassword(encoder.encode(rawTmpPassword));
        }catch (MessagingException e){
            throw new RuntimeException("임시 비밀번호 발급에 실패했습니다.");
        }
    }

    private void sendTemporaryPassword(String to, String rawTmpPassword) throws MessagingException {
        MimeMessage message = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, StandardCharsets.UTF_8.name());
        helper.setFrom(fromAddress);
        helper.setSubject(userMailSubjectContentGenerator.generateSubject());
        helper.setTo(to);
        helper.setText(userMailSubjectContentGenerator.generateContent(rawTmpPassword), true);

        sender.send(message);
    }
}
