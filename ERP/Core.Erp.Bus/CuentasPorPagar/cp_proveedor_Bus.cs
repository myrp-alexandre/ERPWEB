using Core.Erp.Data.CuentasPorPagar;
using Core.Erp.Data.General;
using Core.Erp.Info.CuentasPorPagar;
using DevExpress.Web;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.CuentasPorPagar
{
    public class cp_proveedor_Bus
    {
        cp_proveedor_Data odata = new cp_proveedor_Data();
        tb_persona_Data odata_per = new tb_persona_Data();

        public List<cp_proveedor_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public cp_proveedor_Info get_info(int IdEmpresa, decimal IdProveedor)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdProveedor);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(cp_proveedor_Info info)
        {
            try
            {
                if (info.IdPersona == 0)
                {
                    info.info_persona.pe_telfono_Contacto = info.pr_telefonos;
                    info.info_persona.pe_direccion = info.pr_direccion;
                    info.info_persona.pe_correo = info.pr_correo;
                    info.info_persona.pe_celular = info.pr_celular;

                    info.info_persona = odata_per.armar_info(info.info_persona);
                    if (odata_per.guardarDB(info.info_persona))
                    {
                        info.IdPersona = info.info_persona.IdPersona;
                        return odata.guardarDB(info);
                    }
                }
                else
                    return odata.guardarDB(info);
                return false;
            
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(cp_proveedor_Info info)
        {
            try
            {
                return odata.modificarDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(cp_proveedor_Info info)
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
        public cp_proveedor_Info get_info_x_num_cedula(int IdEmpresa, string pe_cedulaRuc)
        {
            try
            {
                return odata.get_info_x_num_cedula(IdEmpresa, pe_cedulaRuc);
            }
            catch (Exception)
            {

                throw;
            }
        }


        public List<cp_proveedor_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args, int IdEmpresa)
        {
            return odata.get_list_bajo_demanda(args, IdEmpresa);
        }

        public cp_proveedor_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args, int IdEmpresa)
        {
            return odata.get_info_bajo_demanda(args, IdEmpresa);
        }


    }
}
