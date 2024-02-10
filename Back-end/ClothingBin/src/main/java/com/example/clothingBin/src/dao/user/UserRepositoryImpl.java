//package com.example.clothingBin.src.dao.user;//package com.example.clothingBin.src.dao.user;
//
//import com.example.clothingBin.src.domain.refrigeratorGroup.QRefrigeratorGroup;
//import com.example.clothingBin.src.domain.user.QUserDto;
//import com.example.clothingBin.src.service.QTableService;
//import lombok.RequiredArgsConstructor;
//
//import java.util.List;
//
//
//@RequiredArgsConstructor
//public class UserRepositoryImpl extends QTableService implements UserRepositoryCustom {
//
//    @Override
//    public List<UserDto> getTest() {
//        return queryFactory
//                .query().select(new QUserDto(qUser))
//                .from(qUser)
//                .innerJoin(qGroup).on(qGroup.userId.eq(qUser.userId))
//                .fetch()
//                ;
//    }
//
////    private final JPAQueryFactory jpaQueryFactory;
//
//}
