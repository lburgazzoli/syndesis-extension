package io.syndesis.extension;

import java.io.IOException;

import com.github.lalyos.jfiglet.FigletFont;
import io.syndesis.integration.runtime.api.SyndesisActionProperty;
import io.syndesis.integration.runtime.api.SyndesisExtensionAction;
import org.apache.camel.Body;
import org.apache.camel.Handler;
import org.apache.camel.util.ObjectHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@SyndesisExtensionAction(id = "log-body", name = "simple-log", description = "A simple POJO based logging extension")
public class SimpleExtension {
    private static final Logger LOGGER = LoggerFactory.getLogger(SimpleExtension.class);

    // ************************
    // Extension Properties
    // ************************

    @SyndesisActionProperty(name = "ascii", displayName = "ascii", description = "Ascii")
    private boolean ascii;

    @SyndesisActionProperty(name = "font", displayName = "font", description = "Font")
    private String font;

    // ************************
    // Accessors
    // ************************

    public void setAscii(boolean ascii) {
        this.ascii = ascii;
    }

    public boolean isAscii() {
        return this.ascii;
    }

    public String getFont() {
        return font;
    }

    public void setFont(String font) {
        this.font = font;
    }

    // ************************
    // Extension
    // ************************

    @Handler
    public void log(@Body String body) {
        try {
            if (ascii) {
                if (ObjectHelper.isNotEmpty(font)) {
                    LOGGER.info("Body is: \n{}", FigletFont.convertOneLine(font, body));
                } else {
                    LOGGER.info("Body is: \n{}", FigletFont.convertOneLine(body));
                }
            } else {
                LOGGER.info("Body is: {}", body);
            }
        } catch (IOException e) {
            throw ObjectHelper.wrapRuntimeCamelException(e);
        }
    }
}
