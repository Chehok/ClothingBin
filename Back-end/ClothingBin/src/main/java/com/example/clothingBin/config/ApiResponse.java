package com.example.clothingBin.config;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@NoArgsConstructor
public class ApiResponse {
    private Map<String, Object> error = new HashMap<>();
    private List<String> _comment = new ArrayList<>();
    private String redirect;
    private String message;

    @JsonProperty("ds")
    List<?> data = new ArrayList<>();

    @JsonProperty("rs")
    Map<String, Object> map = new HashMap<>();

    @JsonProperty("page")
    PageVo pageVo;

    public ApiResponse(HttpStatus status, String message) {
        error = null;

        if (!status.equals(HttpStatus.OK)) {
            error = new HashMap<String, Object>(){{
                    put("code", status.value());
                    put("message", message);
            }};
        } else if (StringUtils.hasText(message)) {
            this.message = message;
        }

        this.data = null;
        this.map = null;
        this._comment = null;
    }

    public ApiResponse(HttpStatus status, List<?> list) {
        if (!status.equals(HttpStatus.OK)) {
            error = new HashMap<String, Object>(){{
                put("code", status.value());
                put("message", "ERROR");
            }};
        } else {
            error = null;
        }

        this.data = list;
        this.map = null;
    }

    public ApiResponse(String code, String message) {
        error = new HashMap<String, Object>(){{
            put("code", code);
            put("data", message);
        }};

        this.data = null;
        this.map = null;
        this._comment = null;
    }

    public ApiResponse(HttpStatus status, List<String> comment, Map<String, Object> map) {
        this(status, map);
        if (!comment.isEmpty()) {
            this._comment = comment;
        }
    }

    public ApiResponse(HttpStatus status, Map<String, Object> map) {
        if (!status.equals(HttpStatus.OK)) {
            error = new HashMap<String, Object>(){{
                put("code", status.value());
                put("message", "ERROR");
            }};
        } else {
            error = null;
        }

        this.map = map;
    }

    public ApiResponse(HttpStatus status, List<String> comment, List<?> list, PageVo pageVo) {
        this(status, list);
        this.pageVo = pageVo;
        if (!comment.isEmpty()) {
            this._comment = comment;
        }
    }

    public ApiResponse(HttpStatus status, List<?> list, PageVo pageVo) {
        this(status, list);
        this.pageVo = pageVo;
    }


    public ApiResponse(HttpStatus status, List<String> comment, List<?> list, Map<String, Object> map) {
        this(status, list);
        this.map = map;
    }

    public ApiResponse(HttpStatus status, String message, String redirect) {
        this(status, message);
        this.redirect = redirect;
    }

    public ApiResponse(HttpStatus status, Map<String, Object> map, String redirect) {
        this(status, map);
        this.redirect = redirect;
        this._comment = null;
    }

    public ApiResponse(HttpStatus status, List<String> comment, List<?> list) {
        this(status, list);
        if (!comment.isEmpty()) {
            this._comment = comment;
        }
    }

    public static ApiResponse of(HttpStatus status) {
        return new ApiResponse(status, "");
    }

    public static ApiResponse of(String code, String message) {
        return new ApiResponse(code, message);
    }

    public static ApiResponse of(HttpStatus status, String message, String redirect) {
        return new ApiResponse(status, message, redirect);
    }

    public static ApiResponse of(HttpStatus status, List<?> list) {
        return new ApiResponse(status, list);
    }

    public static ApiResponse of(HttpStatus status, List<String> comment, List<?> list) {
        return new ApiResponse(status, comment, list);
    }

    public static ApiResponse of(HttpStatus status, List<?> list, PageVo pageVo) {
        return new ApiResponse(status, list, pageVo);
    }

    public static ApiResponse of(HttpStatus status, List<String> comment, List<?> list, PageVo pageVo) {
        return new ApiResponse(status, comment, list, pageVo);
    }

    public static ApiResponse of(HttpStatus status, Map<String, Object> map, String redirect) {
        return new ApiResponse(status, map, redirect);
    }

    public static ApiResponse of(HttpStatus status, Map<String, Object> map) {
        return new ApiResponse(status, map);
    }
}
