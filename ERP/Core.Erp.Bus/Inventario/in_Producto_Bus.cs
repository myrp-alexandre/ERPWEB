﻿using Core.Erp.Data.Inventario;
using Core.Erp.Info.Helps;
using Core.Erp.Info.Inventario;
using DevExpress.Web;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Inventario
{
    public class in_Producto_Bus
    {
        in_Producto_Data odata = new in_Producto_Data();

        public List<in_Producto_Info> get_list(int IdEmpresa, bool mostrar_anulados)
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

        public List<in_Producto_Info> get_list_para_composicion(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list_para_composicion(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<in_Producto_Info> get_list_combo_padre(int IdEmpresa)
        {
            try
            {
                return odata.get_list_combo_padre(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<in_Producto_Info> get_list_combo_hijo(int IdEmpresa, decimal IdProducto_padre)
        {
            try
            {
                return odata.get_list_combo_hijo(IdEmpresa, IdProducto_padre);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<in_Producto_Info> get_list_padres(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                return odata.get_list_padres(IdEmpresa, mostrar_anulados);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<in_Producto_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args, int IdEmpresa, cl_enumeradores.eTipoBusquedaProducto Busqueda, cl_enumeradores.eModulo Modulo, decimal IdProductoPadre)
        {
            return odata.get_list_bajo_demanda(args, IdEmpresa, Busqueda,Modulo,IdProductoPadre);
        }

        public in_Producto_Info get_info_bajo_demanda(ListEditItemRequestedByValueEventArgs args, int IdEmpresa)
        {
            return odata.get_info_bajo_demanda(args, IdEmpresa);
        }

        public in_Producto_Info get_info(int IdEmpresa, decimal IdProducto)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdProducto);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_Producto_Info info)
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
        public bool guardar_loteDB(int IdEmpresa, decimal IdProducto_padre, DateTime fecha_fab, DateTime fecha_ven, string lote)
        {
            try
            {
                in_Producto_Info info_new_lote = new in_Producto_Info();
                info_new_lote = odata.get_info(IdEmpresa, IdProducto_padre);
                if(info_new_lote!=null)
                {
                    info_new_lote.IdProducto_padre = info_new_lote.IdProducto;
                    info_new_lote.lote_fecha_fab = fecha_fab;
                    info_new_lote.lote_fecha_vcto = fecha_ven;
                    info_new_lote.lote_num_lote = lote;
                    info_new_lote.Estado = "A";
                    info_new_lote.Fecha_Transac = DateTime.Now;
                }
                return odata.guardarDB(info_new_lote);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool modificarDB(in_Producto_Info info)
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
        public bool anularDB(in_Producto_Info info)
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
