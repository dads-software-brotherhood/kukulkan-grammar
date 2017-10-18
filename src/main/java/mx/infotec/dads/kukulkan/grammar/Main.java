package mx.infotec.dads.kukulkan.grammar;

import java.io.IOException;
import java.io.InputStream;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.TokenStream;

import mx.infotec.dads.kukulkan.grammar.parser.kukulkanLexer;
import mx.infotec.dads.kukulkan.grammar.parser.kukulkanParser;
import mx.infotec.dads.kukulkan.grammar.parser.kukulkanParser.Between_expressionContext;
import mx.infotec.dads.kukulkan.grammar.parser.kukulkanParser.Select_clauseContext;
import mx.infotec.dads.kukulkan.grammar.parser.kukulkanParser.Select_statementContext;

/**
 * Main class for Test the grammar
 * 
 * @author Daniel Cortes Pichardo
 *
 */
public class Main {
    public static void main(String[] args) {
        try {
            InputStream inputStream = Main.class.getResourceAsStream("/db.sql");
            kukulkanLexer lexer = new kukulkanLexer(CharStreams.fromStream(inputStream));
            CommonTokenStream tokenStream = new CommonTokenStream(lexer);
            kukulkanParser parser = new kukulkanParser(tokenStream);            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}