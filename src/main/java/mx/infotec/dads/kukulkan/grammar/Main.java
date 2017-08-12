package mx.infotec.dads.kukulkan.grammar;

import java.io.IOException;
import java.io.InputStream;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.TokenStream;

import mx.infotec.dads.kukulkan.grammar.parser.*;
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
            InputStream inputStream = Main.class.getResourceAsStream("/pyth.txt");
            Lexer lexer = new kukulkanLexer(CharStreams.fromStream(inputStream));
            TokenStream tokenStream = new CommonTokenStream(lexer);
            kukulkanParser parser = new kukulkanParser(tokenStream);
            Select_statementContext selectStatemet = parser.select_statement();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}