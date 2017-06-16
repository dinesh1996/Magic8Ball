package org.jahia.modules.magicball.actions;

import org.jahia.bin.Action;
import org.jahia.bin.ActionResult;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.content.JCRValueWrapper;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

/**
 * Created by dsalhotra on 13/06/2017.
 */
public class RandomAnswerAction extends Action {
    private static Logger logger = LoggerFactory.getLogger(RandomAnswerAction.class);

    @Override
    public ActionResult doExecute(HttpServletRequest httpServletRequest,
                                  RenderContext renderContext,
                                  Resource resource,
                                  JCRSessionWrapper jcrSessionWrapper,
                                  Map<String, List<String>> parameters,
                                  URLResolver urlResolver) throws Exception {

        if (!parameters.isEmpty() && parameters.containsKey("nodeIdentifier")) {
            if (parameters.get("nodeIdentifier").size() > 0) {
                String nodeIdentifier = parameters.get("nodeIdentifier").get(0);
                JCRValueWrapper[] values = resource.getNode().getSession().getNodeByIdentifier(nodeIdentifier).getProperty("answer").getValues();
                int randomNum = ThreadLocalRandom.current().nextInt(0, values.length );
                JCRValueWrapper value = values[randomNum];

                JSONObject jsonObject = new JSONObject();
                logger.info("blablabla");
                jsonObject.put("key", value.toString());
                return new ActionResult(HttpServletResponse.SC_OK, null, jsonObject);
            }
        }
        return ActionResult.BAD_REQUEST;
    }
}
