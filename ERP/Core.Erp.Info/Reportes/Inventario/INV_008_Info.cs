using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Inventario
{
    public class INV_008_Info
    {

        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdProducto { get; set; }
        public string pr_codigo { get; set; }
        public string pr_descripcion { get; set; }
        public Nullable<decimal> IdProducto_padre { get; set; }
        public Nullable<System.DateTime> lote_fecha_fab { get; set; }
        public Nullable<System.DateTime> lote_fecha_vcto { get; set; }
        public string lote_num_lote { get; set; }
        public Nullable<double> stock { get; set; }
        public string IdCategoria { get; set; }
        public int IdLinea { get; set; }
        public int IdGrupo { get; set; }
        public int IdSubGrupo { get; set; }
        public string ca_Categoria { get; set; }
        public string IdPresentacion { get; set; }
        public string nom_presentacion { get; set; }
        public string Su_Descripcion { get; set; }
        public string bo_Descripcion { get; set; }


    }
}
