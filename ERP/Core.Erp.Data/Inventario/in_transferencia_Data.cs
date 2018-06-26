using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
namespace Core.Erp.Data.Inventario
{
   public class in_transferencia_Data
    {
        public bool GuardarDB(in_transferencia_Info info, ref decimal _idTransferencia)
        {
            try
            {
                int c = 1;
                using (Entities_inventario contex = new Entities_inventario())
                {
                    in_transferencia address = new in_transferencia
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursalOrigen = info.IdSucursalOrigen,
                        IdBodegaOrigen = info.IdBodegaOrigen,
                        IdTransferencia = info.IdTransferencia = _idTransferencia = get_id(info.IdEmpresa, info.IdSucursalOrigen, info.IdBodegaOrigen),
                        IdSucursalDest = info.IdSucursalDest,
                        IdBodegaDest = info.IdBodegaDest,
                        tr_Observacion = info.tr_Observacion,
                        IdMovi_inven_tipo_SucuOrig = info.IdMovi_inven_tipo_SucuOrig,
                        IdMovi_inven_tipo_SucuDest = info.IdMovi_inven_tipo_SucuDest,
                        tr_fecha = Convert.ToDateTime(info.tr_fecha.ToShortDateString()),
                        Estado = "A",
                        IdUsuario = (info.IdUsuario == null) ? "" : info.IdUsuario,
                        ip = (info.ip == null) ? "" : info.ip,
                        nom_pc = (info.nom_pc == null) ? "" : info.nom_pc,
                        IdEstadoAprobacion_cat = info.IdEstadoAprobacion_cat,
                        Codigo = info.Codigo,
                    };
                    contex.in_transferencia.Add(address);


                    foreach (var item in info.list_detalle)
                    {
                        in_transferencia_det addressDeta = new in_transferencia_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursalOrigen = info.IdSucursalOrigen,
                            IdTransferencia = info.IdTransferencia,
                            IdBodegaOrigen = info.IdBodegaOrigen,
                            IdProducto = item.IdProducto,
                            dt_cantidad = item.dt_cantidad,
                            IdUnidadMedida = item.IdUnidadMedida,
                            tr_Observacion = item.tr_Observacion,
                            IdCentroCosto = item.IdCentroCosto,
                            IdPunto_cargo_grupo = item.IdPunto_cargo_grupo,
                            IdPunto_cargo = item.IdPunto_cargo,
                            IdCentroCosto_sub_centro_costo = item.IdCentroCosto_sub_centro_costo == "" ? null : item.IdCentroCosto_sub_centro_costo,
                            dt_secuencia = item.dt_secuencia = c,
                        };
                        c++;
                        contex.in_transferencia_det.Add(addressDeta);
                    }
                    contex.SaveChanges();



                    return true;

                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        public decimal get_id(int idEmpresa, int idSucursal, int idBodega)
        {
            try
            {
                decimal id;
                using (Entities_inventario Contex = new Entities_inventario())
                {
                    var Select = from q in Contex.in_transferencia
                                 where q.IdEmpresa == idEmpresa && q.IdSucursalOrigen == idSucursal && q.IdBodegaOrigen == idBodega
                                 select q;
                    if (Select.ToList().Count == 0)
                    {
                        return 1;
                    }
                    else
                    {
                        var qmax = (from q in Contex.in_transferencia
                                    where q.IdEmpresa == idEmpresa && q.IdSucursalOrigen == idSucursal && q.IdBodegaOrigen == idBodega
                                    select q.IdTransferencia).Max();

                        id = Convert.ToInt32(qmax.ToString()) + 1;
                        return id;
                    }
                }

            }
            catch (Exception )
            {
               
                throw ;
            }
        }

    }
}
