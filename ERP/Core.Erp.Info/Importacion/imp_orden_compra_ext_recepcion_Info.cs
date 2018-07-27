using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Importacion
{
   public class imp_orden_compra_ext_recepcion_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdRecepcion { get; set; }
        public System.DateTime or_fecha { get; set; }
        public string or_observacion { get; set; }
        public Nullable<int> IdEmpresa_oc { get; set; }
        public decimal IdOrdenCompraExt { get; set; }
        public int IdEmpresa_inv { get; set; }
        public int IdSucursal_inv { get; set; }
        public int IdMovi_inven_tipo_inv { get; set; }
        public decimal IdNumMovi_inv { get; set; }
        public List<imp_orden_compra_ext_recepcion_det_Info> lst_detalle { get; set; }
        public bool estado { get; set; }
        public string IdUsuario_creacion { get; set; }
        public Nullable<System.DateTime> fecha_creacion { get; set; }
        public string IdUsuario_modificacion { get; set; }
        public Nullable<System.DateTime> fecha_modificacion { get; set; }
        public string IdUsuario_anulacion { get; set; }
        public Nullable<System.DateTime> fecha_anulacion { get; set; }

    }
}
