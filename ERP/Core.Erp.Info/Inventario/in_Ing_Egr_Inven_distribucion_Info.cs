using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Inventario
{
   public class in_Ing_Egr_Inven_distribucion_Info
    {
        public decimal IdTransaccionSession { get; set; }
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdMovi_inven_tipo { get; set; }
        public decimal IdNumMovi { get; set; }
        public int secuencia_distribucion { get; set; }
        public int IdEmpresa_dis { get; set; }
        public int IdSucursal_dis { get; set; }
        public int IdMovi_inven_tipo_dis { get; set; }
        public decimal IdNumMovi_dis { get; set; }
        public bool estado { get; set; }
        public string signo { get; set; }

        #region Vista
        public Nullable<double> can_total { get; set; }
        public Nullable<double> can_distribuida { get; set; }
        public Nullable<double> can_x_distribuir { get; set; }
        public string cm_observacion { get; set; }
        public System.DateTime cm_fecha { get; set; }
        public string tm_descripcion { get; set; }
        public string Su_Descripcion { get; set; }
        public int IdBodega { get; set; }
        public decimal IdProducto { get; set; }
        public string IdUnidadMedida { get; set; }
        public Nullable<decimal> IdProducto_padre { get; set; }
        public string pr_descripcion { get; set; }
        public double dm_cantidad { get; set; }
        public double mv_costo { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string vt_NumFactura { get; set; }

        public string IdUsuario { get; set; }
        public Nullable<DateTime> lote_fecha_fab { get; set; }
        public Nullable<DateTime> lote_fecha_vcto { get; set; }
        public string lote_num_lote { get; set; }
        public List<in_Ing_Egr_Inven_distribucion_Info> lst_x_distribuir { get; set; }
        public List<in_Ing_Egr_Inven_distribucion_Info> lst_distribuido { get; set; }


        public string ca_Categoria { get; set; }
        public string nom_presentacion { get; set; }

        #endregion

        public in_Ing_Egr_Inven_distribucion_Info()
        {
            lst_distribuido = new List<in_Ing_Egr_Inven_distribucion_Info>();
            lst_x_distribuir = new List<in_Ing_Egr_Inven_distribucion_Info>(); 
         }
    }
}
