package vn.quanlythuctap;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class MvcTest {
    @Autowired MockMvc mvc;

    @Test void clientAndModulesAreAvailable() throws Exception {
        mvc.perform(get("/")).andExpect(status().isOk());
        for (String id : new String[]{"hoc-vu", "dang-ky", "van-ban", "theo-doi"}) {
            mvc.perform(get("/api/modules/" + id))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.bang[0]").isString());
            mvc.perform(get("/modules/" + id + "/view.js")).andExpect(status().isOk());
        }
    }
}
