using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Importacion
{
   public class imp_liquidacion_det_x_imp_orden_compra_ext_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdLiquidacion { get; set; }
        public int IdEmpresa_oe { get; set; }
        public decimal IdOrdenCompra_ext { get; set; }
        public string observacion { get; set; }
        public string oe_observacion { get; set; }
        public System.DateTime oe_fecha { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_nombreCompleto { get; set; }
        public Nullable<int> IdMoneda_origen { get; set; }
        public Nullable<int> IdMoneda_destino { get; set; }
        public bool Estado_cierre { get; set; }
        public string IdPais_embarque { get; set; }
        public string IdCiudad_destino { get; set; }
        public int IdCatalogo_via { get; set; }
        public int IdCatalogo_forma_pago { get; set; }
        public bool estado { get; set; }
        public string IdUsuario_creacion { get; set; }
        public Nullable<System.DateTime> fecha_creacion { get; set; }
        public string IdUsuario_modificacion { get; set; }
        public Nullable<System.DateTime> fecha_modificacion { get; set; }
        public string IdUsuario_anulacion { get; set; }
        public Nullable<System.DateTime> fecha_anulacion { get; set; }
        public List<imp_orden_compra_ext_ct_cbteble_det_gastos_Info> lst_gastos { get; set; }
        public List<imp_ordencompra_ext_det_Info> lst_detalle_oc { get; set; }

    }
}
