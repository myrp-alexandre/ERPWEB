using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
    public class fa_notaCreDeb_det_Data
    {
        public List<fa_notaCreDeb_det_Info> get_list(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdNota)
        {
            try
            {
                List<fa_notaCreDeb_det_Info> Lista;

                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.vwfa_notaCreDeb_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdBodega == IdBodega
                             && q.IdNota == IdNota
                             select new fa_notaCreDeb_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdNota = q.IdNota,
                                 Secuencia = q.Secuencia,
                                 IdProducto = q.IdProducto,
                                 sc_cantidad = q.sc_cantidad,
                                 sc_Precio = q.sc_Precio,
                                 sc_descUni = q.sc_descUni,
                                 sc_PordescUni = q.sc_PordescUni,
                                 sc_precioFinal = q.sc_precioFinal,
                                 sc_subtotal = q.sc_subtotal,
                                 sc_iva = q.sc_iva,
                                 sc_total = q.sc_total,
                                 sc_costo = q.sc_costo,
                                 sc_observacion = q.sc_observacion,
                                 sc_estado = q.sc_estado,
                                 vt_por_iva = q.vt_por_iva,
                                 IdPunto_Cargo = q.IdPunto_Cargo,
                                 IdPunto_cargo_grupo = q.IdPunto_cargo_grupo,
                                 IdCod_Impuesto_Iva = q.IdCod_Impuesto_Iva,
                                 IdCod_Impuesto_Ice = q.IdCod_Impuesto_Ice,
                                 IdCentroCosto = q.IdCentroCosto,
                                 IdCentroCosto_sub_centro_costo = q.IdCentroCosto_sub_centro_costo,
                                 pr_descripcion = q.pr_descripcion,
                                 nom_presentacion = q.nom_presentacion,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote
                             }).ToList();
                }
                Lista.ForEach(V =>
                {
                    V.pr_descripcion = V.pr_descripcion + " " + V.nom_presentacion + " - " + V.lote_num_lote + " - " + (V.lote_fecha_vcto != null ? Convert.ToDateTime(V.lote_fecha_vcto).ToString("dd/MM/yyyy") : "");
                });

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
