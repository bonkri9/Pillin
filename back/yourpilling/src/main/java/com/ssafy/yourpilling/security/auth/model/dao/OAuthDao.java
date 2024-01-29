package com.ssafy.yourpilling.security.auth.model.dao;

import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;

import java.util.Optional;

public interface OAuthDao {

    Optional<Member> findByUsername(String username);

    void register(Member member);
}
