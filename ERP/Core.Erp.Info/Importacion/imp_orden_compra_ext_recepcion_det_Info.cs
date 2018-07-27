using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Importacion
{
   public class imp_orden_compra_ext_recepcion_det_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdRecepcion { get; set; }
        public int secuencia { get; set; }
        public decimal IdProducto { get; set; }
        public int IdEmpresa_oc { get; set; }
        public decimal IdOrdenCompra_ext { get; set; }
        public int Secuencia_oc { get; set; }
        public int cantidad { get; set; }
        public string Observacion { get; set; }


        public string pr_descripcion { get; set; }

    }
}
