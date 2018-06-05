using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Inventario
{
  public class INV_004_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public int IdMovi_inven_tipo { get; set; }
        public decimal IdNumMovi { get; set; }
        public int Secuencia { get; set; }
        public string mv_tipo_movi { get; set; }
        public string tm_descripcion { get; set; }
        public decimal IdProducto { get; set; }
        public string pr_codigo { get; set; }
        public string pr_descripcion { get; set; }
        public string nom_presentacion { get; set; }
        public Nullable<System.DateTime> lote_fecha_vcto { get; set; }
        public string lote_num_lote { get; set; }
        public System.DateTime cm_fecha { get; set; }
        public string cm_observacion { get; set; }
        public string Su_Descripcion { get; set; }
        public string bo_Descripcion { get; set; }
        public double dm_cantidad { get; set; }
        public double mv_costo { get; set; }
        public string IdUnidadMedida { get; set; }
        public string Descripcion { get; set; }
        public string IdCategoria { get; set; }
        public int IdLinea { get; set; }
        public int IdGrupo { get; set; }
        public int IdSubGrupo { get; set; }
        public Nullable<int> anio { get; set; }
        public Nullable<int> mes { get; set; }
        public Nullable<decimal> IdProducto_padre { get; set; }
        public string pr_descripcion_padre { get; set; }
    }
}
