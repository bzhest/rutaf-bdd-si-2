package com.refinitiv.asts.test.ui.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Languages {

    EN("en", "en_us"),
    DE("de", "de_de"),
    ID("id", "id_id"),
    ZHCN("zhCN", "zh_cn"),
    ZHTW("zhTW", "zh_tw"),
    PT("pt", "pt_pt"),
    ES("es", "es_es"),
    IT("it", "it_it"),
    EL("el", "el_el"),
    FIL("fil", "fil_fil"),
    JA("ja", "ja_ja"),
    KO("ko", "ko_ko"),
    MS("ms", "ms_ms"),
    NL("nl", "nl_nl"),
    PL("pl", "pl_pl"),
    RU("ru", "ru_ru"),
    TH("th", "th_th"),
    TR("tr", "tr_tr"),
    VI("vi", "vi_vi"),
    FR("fr", "fr_fr");

    private String code;
    private String apiCode;

}