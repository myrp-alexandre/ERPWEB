using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    public static class tb_sis_log_error_InfoList
    {
        public static string DescripcionError { get; set; }
    }
}
