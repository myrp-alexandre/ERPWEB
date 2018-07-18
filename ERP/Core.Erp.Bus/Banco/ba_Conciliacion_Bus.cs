using Core.Erp.Data.Banco;
using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Banco
{
    public class ba_Conciliacion_Bus
    {
        ba_Conciliacion_Data odata = new ba_Conciliacion_Data();
        public List<ba_Conciliacion_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                return odata.get_list(IdEmpresa, Fecha_ini, Fecha_fin);
            }
            catch (Exception)
            {
                throw;
            }            
        }

        public ba_Conciliacion_Info get_info(int IdEmpresa, decimal IdConciliacion)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdConciliacion);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool ExisteConciliacion(int IdEmpresa, int IdPeriodo, int IdBanco)
        {
            try
            {
                return odata.ExisteConciliacion(IdEmpresa, IdPeriodo, IdBanco);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ba_Conciliacion_Info info)
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

        public bool modificarDB(ba_Conciliacion_Info info)
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

        public bool anularDB(ba_Conciliacion_Info info)
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
    }
}
