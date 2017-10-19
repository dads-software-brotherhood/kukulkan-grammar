
package mx.infotec.dads.kukulkan.grammar;

import java.util.Optional;

/**
 * KukulkanCustomVisitor, this is the main visitor for kukulkan grammar
 * 
 * @author Daniel Cortes Pichardo
 *
 */
public class kukulkanCustomVisitor extends kukulkanBaseVisitor<Object> {
    @Override
    public Object visitDomainModel(kukulkanParser.DomainModelContext ctx) {
        ctx.entities.forEach(entity -> {
            
            System.out.println(entity.name.getText());
            Optional.ofNullable(entity.tableName).ifPresent(tableName -> System.out.println(tableName.getText()));
            entity.fields.forEach(field ->{
                System.out.println(field.id.getText());
            });;
            
        });
        return visitChildren(ctx);
    }

}
