using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Facturacion
{
    public class fa_CambioProducto_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public int IdCambio { get; set; }
        public System.DateTime Fecha { get; set; }
        public string Observacion { get; set; }
        public bool Estado { get; set; }
        public Nullable<int> IdMovi_inven_tipo { get; set; }
        public Nullable<decimal> IdNumMovi { get; set; }
        public List<fa_CambioProductoDet_Info> LstDet { get; set; }

    }
}
