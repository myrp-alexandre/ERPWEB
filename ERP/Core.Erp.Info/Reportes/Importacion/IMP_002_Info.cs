﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Importacion
{
   public class IMP_002_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdOrdenCompra_ext { get; set; }
        public decimal IdProveedor { get; set; }
        public string IdPais_origen { get; set; }
        public string IdPais_embarque { get; set; }
        public string IdCiudad_destino { get; set; }
        public int IdCatalogo_via { get; set; }
        public int IdCatalogo_forma_pago { get; set; }
        public System.DateTime oe_fecha { get; set; }
        public Nullable<System.DateTime> oe_fecha_llegada_est { get; set; }
        public Nullable<System.DateTime> oe_fecha_embarque_est { get; set; }
        public Nullable<System.DateTime> oe_fecha_desaduanizacion_est { get; set; }
        public string IdCtaCble_importacion { get; set; }
        public string oe_observacion { get; set; }
        public string oe_codigo { get; set; }
        public bool estado { get; set; }
        public Nullable<System.DateTime> oe_fecha_llegada { get; set; }
        public Nullable<System.DateTime> oe_fecha_embarque { get; set; }
        public Nullable<System.DateTime> oe_fecha_desaduanizacion { get; set; }
        public Nullable<int> IdMoneda_origen { get; set; }
        public Nullable<int> IdMoneda_destino { get; set; }
        public string Paisembarque { get; set; }
        public string PaisOrigen { get; set; }
        public string FormaPago { get; set; }
        public string ViaEmbarque { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_nombreCompleto { get; set; }
        public string pr_codigo { get; set; }
        public string Expr1 { get; set; }
        public string pr_descripcion { get; set; }
        public Nullable<System.DateTime> lote_fecha_fab { get; set; }
        public Nullable<System.DateTime> lote_fecha_vcto { get; set; }
        public string lote_num_lote { get; set; }
        public double od_cantidad { get; set; }
        public double od_costo { get; set; }
        public double od_por_descuento { get; set; }
        public double od_descuento { get; set; }
        public double od_costo_final { get; set; }
        public double od_subtotal { get; set; }
        public double od_cantidad_recepcion { get; set; }
        public double od_costo_convertido { get; set; }
        public double od_total_fob { get; set; }
        public double od_factor_costo { get; set; }
        public double od_costo_bodega { get; set; }
        public double od_costo_total { get; set; }
        public string IdUnidadMedida { get; set; }
        public string Descripcion_Ciudad { get; set; }
    }
}
