package vn.quanlythuctap.modules.theodoi;

import java.util.List;
import org.springframework.stereotype.Component;
import vn.quanlythuctap.common.ThongTinModule;

@Component
public class TheoDoiModel {
    public ThongTinModule layThongTin() {
        return new ThongTinModule("Theo dõi và đánh giá", List.of(
            "Lịch biểu thực tập",
            "Nhật ký và chuyên cần",
            "Sự cố và giám sát",
            "Lịch sử xử lý",
            "Phiếu đánh giá",
            "Tiêu chí chấm điểm",
            "Điểm theo tiêu chí",
            "Kết quả thực tập"
        ));
    }
}
