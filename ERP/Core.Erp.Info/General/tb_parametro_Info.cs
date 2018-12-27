using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.General
{
    public class tb_parametro_Info
    {
        public int IdEmpresa { get; set; }
        public string IdCod_Impuesto { get; set; }
        public double Porcentaje { get; set; }
        public bool EsMultiSucursal { get; set; }
    }
}
