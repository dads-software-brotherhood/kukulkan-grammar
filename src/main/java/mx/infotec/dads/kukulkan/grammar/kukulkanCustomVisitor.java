
package mx.infotec.dads.kukulkan.grammar;

/**
 * KukulkanCustomVisitor, this is the main visitor for kukulkan grammar
 * 
 * @author Daniel Cortes Pichardo
 *
 */
public class kukulkanCustomVisitor extends kukulkanBaseVisitor<Object> {
    @Override
    public Object visitEntity(kukulkanParser.EntityContext ctx) {
        ctx.entityField().forEach(field -> {
        });
        return visitChildren(ctx);
    }
}
