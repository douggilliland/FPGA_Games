
/**
 * Write a description of class main here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class main
{
    // instance variables - replace the example below with your own
    

    /**
     * Constructor for objects of class main
     */
    public main()
    {
        //initializer(3,9);
        elseifer(6,9);
        //iner(3,9);
    }

    /**
     * An example of a method - replace this comment with your own
     * 
     * @param  y   a sample parameter for a method
     * @return     the sum of x and y 
     */
    public void initializer(int start, int end)
    {
       for(int i =start; i<=end; i++){
            System.out.println("--block "+i);
            System.out.println("b"+i+"topline    :IN INTEGER;");
            System.out.println("b"+i+"bottomline :IN INTEGER;");
            System.out.println("b"+i+"leftline   :IN INTEGER;");
            System.out.println("b"+i+"rightline  :IN INTEGER;");
            System.out.println("");
       }
    }
     public void elseifer(int start, int end)
    {
            for(int i =start; i<=end; i++){
            System.out.println("--block "+i);
            System.out.println("ELSIF (row> b"+i+"topline AND row<b"+i+"bottomline and column>b"+i+"leftline and column<b"+i+"rightline) THEN");
            System.out.println("red <= (OTHERS => '1');");
            System.out.println("green	<= (OTHERS => '1');");
            System.out.println("blue <= (OTHERS => '1');");
        }
    }
     public void iner(int start, int end)
    {
       for(int i =start; i<=end; i++){
            System.out.println("b"+i+"topline, "+"b"+i+"bottomline, "+"b"+i+"leftline, "+"b"+i+"rightline,");
        }
    }
}
