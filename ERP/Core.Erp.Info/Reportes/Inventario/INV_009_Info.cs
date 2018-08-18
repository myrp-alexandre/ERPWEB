using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Inventario
{
    public class INV_009_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public Nullable<decimal> IdProducto { get; set; }
        public string pr_descripcion { get; set; }
        public Nullable<int> IdMarca { get; set; }
        public string NomMarca { get; set; }
        public string IdPresentacion { get; set; }
        public string nom_presentacion { get; set; }
        public Nullable<int> IdProductoTipo { get; set; }
        public string tp_descripcion { get; set; }
        public string lote_num_lote { get; set; }
        public Nullable<System.DateTime> lote_fecha_vcto { get; set; }
        public Nullable<double> precio_1 { get; set; }
        public Nullable<double> dm_cantidad { get; set; }
        public Nullable<double> CostoTotal { get; set; }
        public decimal IdProducto_padre { get; set; }
        public string Su_Descripcion { get; set; }
        public string bo_Descripcion { get; set; }
        public Nullable<double> PrecioTotal { get; set; }
    }
}
