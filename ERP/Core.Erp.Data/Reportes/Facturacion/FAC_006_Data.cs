using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Facturacion
{
    public class FAC_006_Data
    {
        public List<FAC_006_Info> get_list(int IdEmpresa, int IdSucursal, decimal IdProforma, bool formato_hoja_membretada, bool mostrar_imagen)
        {
            try
            {
                List<FAC_006_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWFAC_006
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdProforma == IdProforma
                             select new FAC_006_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdProforma = q.IdProforma,
                                 Secuencia = q.Secuencia,
                                 nom_TerminoPago = q.nom_TerminoPago,
                                 pf_plazo = q.pf_plazo,
                                 pf_codigo = q.pf_codigo,
                                 pf_fecha = q.pf_fecha,
                                 estado = q.estado,
                                 pf_atencion_a = q.pf_atencion_a,
                                 Codigo = q.Codigo,
                                 Ve_Vendedor = q.Ve_Vendedor,
                                 pr_descripcion = q.pr_descripcion,
                                 pd_cantidad = q.pd_cantidad,
                                 pd_precio = q.pd_precio,
                                 pd_descuento_uni = q.pd_descuento_uni,
                                 pd_por_descuento_uni = q.pd_por_descuento_uni,
                                 pd_precio_final = q.pd_precio_final,
                                 pd_subtotal = q.pd_subtotal,
                                 pd_iva = q.pd_iva,
                                 pd_por_iva = q.pd_por_iva,
                                 pd_total = q.pd_total,
                                 pr_dias_entrega = q.pr_dias_entrega,
                                 IdProducto = q.IdProducto,
                                 nom_marca = q.nom_marca,
                                 nom_modelo = q.nom_modelo,
                                 pr_observacion = q.pr_observacion,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote,
                                 pf_observacion = q.pf_observacion,
                                 IdProducto_padre = q.IdProducto_padre
                             }).ToList();
                }
                if (mostrar_imagen)
                {
                    using (Entities_inventario Context = new Entities_inventario())
                    {
                        foreach (var item in Lista)
                        {
                            var producto = Context.in_Producto.Where(q => q.IdEmpresa == item.IdEmpresa && q.IdProducto == (item.IdProducto_padre == null ? item.IdProducto : item.IdProducto_padre)).FirstOrDefault();
                            if (producto != null && producto.pr_imagen != null)
                            {
                                item.pr_imagen = producto.pr_imagen;
                                item.Detalle ="MARCA: " + item.nom_marca + " \r\nMODELO: " + item.nom_modelo + (producto.pr_observacion == null ? "" : "\r\nCARACTERISTICAS:\r\n" + producto.pr_observacion);
                            }
                        }
                    }
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
