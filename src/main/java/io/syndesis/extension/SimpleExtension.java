package io.syndesis.extension;

import java.io.IOException;

import org.apache.camel.Body;
import org.apache.camel.util.ObjectHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.lalyos.jfiglet.FigletFont;

import io.syndesis.integration.runtime.api.SyndesisActionProperty;
import io.syndesis.integration.runtime.api.SyndesisExtensionAction;

public class SimpleExtension {
    private static final Logger LOGGER = LoggerFactory.getLogger(SimpleExtension.class);
    private boolean ascii;

    public void setAscii(boolean ascii) {
        this.ascii = ascii;
    }

    public boolean isAscii() {
        return this.ascii;
    }

    @SyndesisActionProperty(
        name = "ascii",
        displayName = "ascii",
        description = "Ascii"
    )
    @SyndesisExtensionAction(
        id = "log-body", 
        name = "simple-log", 
        description = "A simple function based logging extension (1)"
    )
    public void log(@Body String body) {
        try {
            if (ascii) {
                LOGGER.info("Body is: \n{}", FigletFont.convertOneLine(body));
            } else {
                LOGGER.info("Body is: {}", body);
            }
        } catch (IOException e) {
            throw ObjectHelper.wrapRuntimeCamelException(e);
        }
    }
}