package vn.quanlythuctap.modules.vanban;

import java.util.List;
import org.springframework.stereotype.Component;
import vn.quanlythuctap.common.ThongTinModule;

@Component
public class VanBanModel {
    public ThongTinModule layThongTin() {
        return new ThongTinModule("Văn bản và ký duyệt", List.of(
            "Văn bản và phiên bản",
            "Chữ ký xác nhận",
            "Đề cương thực tập"
        ));
    }
}
