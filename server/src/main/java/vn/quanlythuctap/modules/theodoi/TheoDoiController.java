package vn.quanlythuctap.modules.theodoi;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.quanlythuctap.common.ThongTinModule;

@RestController
public class TheoDoiController {
    private final TheoDoiModel model;

    public TheoDoiController(TheoDoiModel model) {
        this.model = model;
    }

    @GetMapping("/api/modules/theo-doi")
    public ThongTinModule layThongTin() {
        return model.layThongTin();
    }
}
