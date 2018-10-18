using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Helps
{
    public class cl_funciones
    {
        public static string convertir_string_MD5Hash(string input)
        {
            MD5 md5Hash = MD5.Create();

            // Convert the input string to a byte array and compute the hash.
            byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));

            // Create a new Stringbuilder to collect the bytes
            // and create a string.
            StringBuilder sBuilder = new StringBuilder();

            // Loop through each byte of the hashed data 
            // and format each one as a hexadecimal string.
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            // Return the hexadecimal string.
            return sBuilder.ToString();
        }

        // NUMERO A LETRA
        public string NumeroALetras(string num)
        {
            string res, dec = "";
            Int64 entero;
            int decimales;
            double nro;
            try
            {
                nro = Convert.ToDouble(num);
            }
            catch
            {
                return "";
            }

            entero = Convert.ToInt64(Math.Truncate(nro));
            decimales = Convert.ToInt32(Math.Round((nro - entero) * 100, 2));
            if (decimales > 0)
            {
                if (decimales < 10)
                    dec = " CON 0" + decimales.ToString() + "/100 ****";
                else
                    dec = " CON " + decimales.ToString() + "/100 ****";
            }
            else
                dec = " CON 00/100 ****";

            res = NumeroALetras(Convert.ToDecimal(entero)) + dec;
            return res;
        }

        static string NumeroALetras(decimal value)
        {
            string Num2Text = "";
            value = Math.Truncate(value);
            if (value == 0) Num2Text = "CERO";

            else if (value == 1) Num2Text = "UNO";

            else if (value == 2) Num2Text = "DOS";

            else if (value == 3) Num2Text = "TRES";

            else if (value == 4) Num2Text = "CUATRO";

            else if (value == 5) Num2Text = "CINCO";

            else if (value == 6) Num2Text = "SEIS";

            else if (value == 7) Num2Text = "SIETE";

            else if (value == 8) Num2Text = "OCHO";

            else if (value == 9) Num2Text = "NUEVE";

            else if (value == 10) Num2Text = "DIEZ";

            else if (value == 11) Num2Text = "ONCE";

            else if (value == 12) Num2Text = "DOCE";

            else if (value == 13) Num2Text = "TRECE";

            else if (value == 14) Num2Text = "CATORCE";

            else if (value == 15) Num2Text = "QUINCE";

            else if (value < 20) Num2Text = "DIECI" + NumeroALetras(Convert.ToDecimal((value - 10)));

            else if (value == 20) Num2Text = "VEINTE";

            else if (value < 30) Num2Text = "VEINTI" + NumeroALetras(Convert.ToDecimal((value - 20)));

            else if (value == 30) Num2Text = "TREINTA";

            else if (value == 40) Num2Text = "CUARENTA";

            else if (value == 50) Num2Text = "CINCUENTA";

            else if (value == 60) Num2Text = "SESENTA";

            else if (value == 70) Num2Text = "SETENTA";

            else if (value == 80) Num2Text = "OCHENTA";

            else if (value == 90) Num2Text = "NOVENTA";

            else if (value < 100) Num2Text = NumeroALetras(Convert.ToDecimal((Math.Truncate(value / 10) * 10))) + " Y " + NumeroALetras(Convert.ToDecimal((value % 10)));

            else if (value == 100) Num2Text = "CIEN";

            else if (value < 200) Num2Text = "CIENTO " + NumeroALetras(Convert.ToDecimal((value - 100)));

            else if ((value == 200) || (value == 300) || (value == 400) || (value == 600) || (value == 800)) Num2Text = NumeroALetras(Convert.ToDecimal((value / 100))) + "CIENTOS";

            else if (value == 500) Num2Text = "QUINIENTOS";

            else if (value == 700) Num2Text = "SETECIENTOS";

            else if (value == 900) Num2Text = "NOVECIENTOS";

            else if (value < 1000) Num2Text = NumeroALetras(Convert.ToDecimal((Math.Truncate(value / 100) * 100))) + " " + NumeroALetras(Convert.ToDecimal((value % 100)));

            else if (value == 1000) Num2Text = "UN MIL";

            else if (value < 2000) Num2Text = "UN MIL " + NumeroALetras(Convert.ToDecimal((value % 1000)));

            else if (value < 1000000)
            {
                Num2Text = NumeroALetras(Convert.ToDecimal((Math.Truncate(value / 1000)))) + " MIL";

                if ((value % 1000) > 0) Num2Text = Num2Text + " " + NumeroALetras(Convert.ToDecimal((value % 1000)));
            }



            else if (value == 1000000) Num2Text = "UN MILLON";

            else if (value < 2000000) Num2Text = "UN MILLON " + NumeroALetras(Convert.ToDecimal((value % 1000000)));

            else if (value < 1000000000000)
            {
                Num2Text = NumeroALetras(Convert.ToDecimal((value / 1000000))) + " MILLONES ";

                if ((value - Math.Truncate(value / 1000000) * 1000000) > 0) Num2Text = Num2Text + " " + NumeroALetras(Convert.ToDecimal((value - Math.Truncate(value / 1000000) * 1000000)));
            }

            else if (value == 1000000000000) Num2Text = "UN BILLON";

            else if (value < 2000000000000) Num2Text = "UN BILLON " + NumeroALetras(Convert.ToDecimal((value - Math.Truncate(value / 1000000000000) * 1000000000000)));

            else
            {
                Num2Text = NumeroALetras(Convert.ToDecimal((Math.Truncate(value / 1000000000000)))) + " BILLONES";

                if ((value - Math.Truncate(value / 1000000000000) * 1000000000000) > 0) Num2Text = Num2Text + " " + NumeroALetras(Convert.ToDecimal((value - Math.Truncate(value / 1000000000000) * 1000000000000)));
            }
            return Num2Text;
        }

        public static string QuitartildesEspaciosPuntos(string cadena)
        {
            try
            {
                //if (cadena == null)
                //    cadena = "";
                string Convertida = cadena;
                Convertida = Convertida.Trim();
                Convertida = Convertida.Replace("S.A","");
                Convertida = Convertida.Replace("CIA.", "");
                Convertida = Convertida.Replace("LTDA.", "");
                Convertida = Convertida.Replace("Ñ", "N").ToUpper();
                Convertida = Convertida.Replace("Á", "A").ToUpper();
                Convertida = Convertida.Replace("É", "E").ToUpper();
                Convertida = Convertida.Replace("Í", "I").ToUpper();
                Convertida = Convertida.Replace("Ú", "U").ToUpper();
                Convertida = Convertida.Replace("Ó", "O").ToUpper();
                Convertida = Convertida.Replace(".", "");

                Convertida = Convertida.Trim();


                return Convertida;
            }
            catch (Exception)
            {


                throw;
            }
        }
    }
}
