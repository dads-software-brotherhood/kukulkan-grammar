
package mx.infotec.dads.kukulkan.grammar;

import org.antlr.v4.runtime.tree.ParseTree;

public class kukulkanCustomVisitor extends kukulkanBaseVisitor<Object> {

    @Override
    public Object visit(ParseTree tree) {
        System.out.println(tree.getText());
        return tree.accept(this);
    }

}
