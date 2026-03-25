package sollecitom.skeleton

import assertk.assertThat
import assertk.assertions.isEqualTo
import org.junit.jupiter.api.Test

class AppTest {

    @Test
    fun `sanity check`() {
        assertThat(1 + 1).isEqualTo(2)
    }
}
