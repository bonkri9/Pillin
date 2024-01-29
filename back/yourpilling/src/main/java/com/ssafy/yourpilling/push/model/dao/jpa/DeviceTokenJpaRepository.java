package com.ssafy.yourpilling.push.model.dao.jpa;

import com.ssafy.yourpilling.push.model.dao.entity.DeviceToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface DeviceTokenJpaRepository extends JpaRepository<DeviceToken, Long> {

    Optional<DeviceToken> findByMemberMemberIdAndDeviceToken(Long memberId, String deviceToken);

}
