package com.example.clothingBin.config;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Getter
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ErrorCode implements EnumModel {
    INVALID_CODE(400, "1110", "INVALID_CODE"), //잘못된 코드 입니다.
    INVALID_VALUE(400, "1120", "INVALID_VALUE"), //잘못된 필드값
    INVALID_PATTERN(400, "1130", "INVALID_PATTERN"), //잘못된 형식
    EMPTY_VALUE(400, "1140", "EMPTY_VALUE"), //필드값 누락
    DOWNLOAD_NOT_FOUND(400, "1150", "DOWNLOAD_NOT_FOUND"), //다운로드 자료를 찾을 수 없습니다.
    UPLOAD_SIZE_ERROR(400, "1160", "UPLOAD_SIZE_ERROR"), //업로드 크기 초과
    FILE_EXTEND_ERROR(400, "1170", "FILE_EXTEND_ERROR"), //파일 확장자 오류
    TYPE_MISMATCH(400, "1180", "TYPE_MISMATCH"), //타입 오류
    PARAMETER_MISMATCH(400, "1190", "PARAMETER_MISMATCH"), //파라미터 타입 오류
    NULL_POINT_EXCEPTION(400, "1210", "NULL_POINT_EXCEPTION"), //Null Point Exception
    EXISTS_USER(400, "1220", "EXISTS_USER"), //사용중인 아이디입니다.
    JDBC_PARAM_ERROR(400, "1230", "JDBC_PARAM_ERROR"), //JDBC 파라미터 오류
    ARGUMENT_EXCEPTION(400, "1240", "ARGUMENT_EXCEPTION"), //ARGUMENT EXCEPTION
    METHOD_NOT_SUPPORT(400, "1250", "METHOD_NOT_SUPPORT"), //METHOD NOT SUPPORT
    NOT_EXISTS_DEVICE(400, "1260", "NOT_EXISTS_DEVICE"), //등록되지 않는 단말기 입니다
    EXISTS_DEVICE_KEY(400, "1270", "EXISTS_DEVICE_KEY"), //기존에 발급된 키를 폐기한 후 재발급 가능합니다. 관리자에게 문의하십시오.
    NOT_PUBLISH_KEY(400, "1280", "NOT_PUBLISH_KEY"), //해당 기기에 발급된 키가 존재하지 않습니다.
    DENIED_PUBLISH_KEY(400, "1290", "DENIED_PUBLISH_KEY"), //인증 문자열이 유효하지 않습니다.
    DENIED_REQUEST_DATE(400, "1300", "DENIED_REQUEST_DATE"), //요청일자가 유효하지 않습니다.
    EXISTS_APPLY_DATE(400, "1310", "EXISTS_APPLY_DATE"), //확정 데이터가 존재합니다.
    PASSWORD_DUPLICATE(400, "1320", "PASSWORD DUPLICATE"), //비밀번호 중복

    DATA_NOT_FOUND(400, "2110", "DATA_NOT_FOUND"), //데이터를 찾을 수 없습니다.
    DELETE_NOT_EXECUTE(400, "2120", "DELETE_NOT_EXECUTE"), //삭제 하실 수 없습니다.
    UPDATE_NOT_EXECUTE(400, "2230", "UPDATE_NOT_EXECUTE"), //수정 하실 수 없습니다.
    SAVE_NOT_EXECUTE(400, "2240", "SAVE_NOT_EXECUTE"), //저장 하실 수 없습니다.
    SQL_SYNTAX_ERROR(400, "2250", "SQL_SYNTAX_ERROR"), //SQL 구문 오류
    SQL_DUPLICATE_ERROR(400, "2260", "SQL_DUPLICATE_ERROR"), //SQL 중복 키 오류
    SQL_DATA_INTEGRITY(400, "2270", "SQL_DATA_INTEGRITY"), //SQL DataIntegrityViolation
    SQL_SAVE_ERROR(400, "2280", "SQL_SAVE_ERROR"), //SQL 저장 오류
    MAIN_CUST_DUPLICATE_ERROR(400, "2290", "MAIN_CUST_DUPLICATE_ERROR"), //메인정산업체 중복 오류
    TIME_DUPLICATE_ERROR(400, "2300", "TIME_DUPLICATE_ERROR"), //식구분 중복시간 오류

    LOGIN_FAILED(403, "4110", "LOGIN_FAILED"), //로그인 실패
    PASSWORD_NOT_MATCH(403, "4110", "PASSWORD_NOT_MATCH"), //비밀번호 불일치
    ACCESS_DENIED(403, "4130", "ACCESS_DENIED"), //접근 권한 오류
    THROWABLE(403, "4140", "THROWABLE"), //Throwable
    METHOD_ARGUMENT(403, "4150", "METHOD_ARGUMENT"), //Method Argument
    RUNTIME_EXCEPTION(403, "4160", "RUNTIME_EXCEPTION"), //Runtime Exception
    REMOTE_EXCEPTION(403, "4170", "REMOTE_EXCEPTION"), //Remote Exception
    SAME_REQ_EXCEPTION(403, "4180", "SAME_REQ_EXCEPTION"), //Same Request Exception

    EXPIRED_TOKEN(403, "9110", "EXPIRED_TOKEN"), //토큰이 만료되었습니다.
    INVALID_TOKEN(403, "9120", "INVALID_TOKEN"), //토큰이 유효하지 않습니다.

    NO_V2_CUST_INFO(403, "10120", "NO_V2_CUST_INFO"), //V2사원 정보가 없습니다.

    NO_TEMP_YN_DATA(403, "10130", "NO_TEMP_YN_DATA"), //일반카드,임시카드정보가 없습니다.
    NO_PARAMETER(403, "10140", "NO_PARAMETER"), //필수 파라메터 없음
    NO_CUST_COMP_FOUND(403, "10150", "NO_CUST_COMP_FOUND"), //고객사 정보가 없습니다.
    NO_CUST_FOUND(403, "10160", "NO_CUST_FOUND"), //사원정보가 없습니다.
    NO_CARD_FONUD(201, "10170", "NO_CARD_FONUD"); //카드정보가 없습니다.

    private int status;
    private String code;
    private String message;
    private String detail;

    ErrorCode(int status, String code, String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }

    @Override
    public String getKey() {
        return this.code;
    }

    @Override
    public String getValue() {
        return this.message;
    }
}
