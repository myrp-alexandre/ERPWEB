using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Inventario
{
   public class in_producto_x_tb_bodega_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdProducto { get; set; }
        public string IdCtaCble_Inven { get; set; }
        public string IdCtaCble_Costo { get; set; }
        public string IdCtaCble_Gasto_x_cxp { get; set; }
        public string IdCtaCble_Vta { get; set; }

        public int Secuencia { get; set; }

    }
}
