using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Inventario
{
   public class INV_012_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdProducto { get; set; }
        public string NomSucursal { get; set; }
        public string NomBodega { get; set; }
        public string NomMarca { get; set; }
        public string NomPresentacion { get; set; }
        public string NomProducto { get; set; }
        public Nullable<System.DateTime> lote_fecha_vcto { get; set; }
        public string lote_num_lote { get; set; }
        public Nullable<decimal> IdProducto_padre { get; set; }
        public Nullable<int> DiasAVencer { get; set; }
        public double StockActual { get; set; }
    }
}
