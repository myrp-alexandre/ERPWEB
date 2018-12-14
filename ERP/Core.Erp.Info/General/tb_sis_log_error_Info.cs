using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Core.Erp.Info.General
{
  public  class tb_sis_log_error_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdError { get; set; }
        public string DescripcionError { get; set; }
        public string Modulo { get; set; }
        public string Accion { get; set; }
    }
    public class tb_sis_log_error_InfoList
    {
        public string DescripcionError { get; set; }

        public class tb_sis_log_error_List
        {
            string Variable = "tb_sis_log_error_Info";
            public string get_list()
            {
                if (HttpContext.Current.Session[Variable] == null)
                {
                    string var = "";

                    HttpContext.Current.Session[Variable] = var;
                }
                return HttpContext.Current.Session[Variable].ToString();
            }

            public void set_list(string var)
            {
                HttpContext.Current.Session[Variable] = var;
            }
        }
    }
}
