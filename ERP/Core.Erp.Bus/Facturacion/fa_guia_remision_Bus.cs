﻿using Core.Erp.Data.Facturacion;
using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Facturacion
{
   public class fa_guia_remision_Bus
    {
        fa_guia_remision_Data odata = new fa_guia_remision_Data();
        fa_guia_remision_det_Data odata_det = new fa_guia_remision_det_Data();
        fa_guia_remision_det_x_factura_Data odata_guia_x_fac = new fa_guia_remision_det_x_factura_Data();
        public List<fa_guia_remision_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa,fecha_inicio, fecha_fin);
            }
            catch (Exception)
            {

                throw;
            }
        }
      
        public fa_guia_remision_Info get_info(int IdEmpresa, decimal IdGuiaRemision)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdGuiaRemision);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(fa_guia_remision_Info info)
        {
            try
            {
                return odata.guardarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(fa_guia_remision_Info info)
        {
            try
            {
                odata_det.eliminar(info.IdEmpresa, info.IdGuiaRemision);
                odata_guia_x_fac.eliminar(info.IdEmpresa, info.IdGuiaRemision);
                return odata.modificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool anularDB(fa_guia_remision_Info info)
        {
            try
            {
                return odata.anularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public string validar(fa_guia_remision_Info info)
        {
            try
            {
                info.ip = "";
                info.nom_pc = "";

                string mensaje = "";
                if (info.IdCliente == 0)
                    mensaje = "Seleccione cliente";
                if (info.lst_detalle == null)
                    mensaje = "No existe detalle para la guia";
                else
                    if(info.lst_detalle.Count()==0)
                    mensaje = "No existe detalle para la guia";

                return mensaje;

            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}