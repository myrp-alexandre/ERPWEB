﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Importacion;
namespace Core.Erp.Data.Importacion
{
   public class imp_orden_compra_ext_recepcion_det_Data
    {
        public List<imp_orden_compra_ext_recepcion_det_Info> get_list(int IdEmpresa, decimal IdOrdenCompra_ext)
        {
            try
            {
                List<imp_orden_compra_ext_recepcion_det_Info> Lista;
                using (Entities_importacion Context = new Entities_importacion())
                {
                    Lista = (from q in Context.imp_orden_compra_ext_recepcion_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdOrdenCompra_ext == IdOrdenCompra_ext
                             select new imp_orden_compra_ext_recepcion_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdRecepcion = q.IdRecepcion,
                                 secuencia = q.secuencia,
                                 IdProducto = q.IdProducto,                                
                                 IdEmpresa_oc=q.IdEmpresa_oc,
                                 IdOrdenCompra_ext = q.IdOrdenCompra_ext,
                                 Secuencia_oc=q.Secuencia_oc,
                                 cantidad=q.cantidad,
                                 Observacion=q.Observacion

                             }).ToList();
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