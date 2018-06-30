using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
using Core.Erp.Data.Inventario;
namespace Core.Erp.Bus.Inventario
{
   public class in_Ing_Egr_Inven_distribucion_Bus
    {
        in_Ing_Egr_Inven_distribucion_Data oData = new in_Ing_Egr_Inven_distribucion_Data();

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                return oData.get_list(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public in_Ing_Egr_Inven_distribucion_Info get_info(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi, string signo)
        {
            try
            {
                return oData.get_info(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi, signo);
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo)
        {
            try
            {
                return oData.get_list(IdEmpresa, IdSucursal, IdMovi_inven_tipo);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list_x_distribuir(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                return oData.get_list_x_distribuir(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list_distribuido(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                return oData.get_list_distribuido(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public bool guardarDB(List<in_Ing_Egr_Inven_distribucion_Info> lista)
        {
            try
            {
                return oData.guardarDB(lista);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public bool guardarDB(in_Ing_Egr_Inven_distribucion_Info info)
        {
            try
            {
                return oData.guardarDB(info);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, int IdNumMovi)
        {
            try
            {
                return oData.eliminarDB(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception )
            {
                throw;
            }
        }
    }
}

